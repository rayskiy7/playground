import concurrent.futures as concfu
import asyncpg
import asyncio
import functools
import util


QUERY = """
    SELECT
        p.product_id,
        p.product_name,
        p.brand_id,
        s.sku_id,
        pc.product_color_name,
        ps.product_size_name
    FROM product as p
    JOIN sku as s on s.product_id = p.product_id
    JOIN product_color as pc on pc.product_color_id = s.product_color_id
    JOIN product_size as ps on ps.product_size_id = s.product_size_id
    WHERE p.product_id = 100
"""


async def query(connection_pool):
    async with connection_pool.acquire() as connection:
        return await connection.fetchrow(QUERY)


# def make_queries(count):
#     async def run_queries():
#         async with asyncpg.create_pool(
#             host='127.0.0.1',
#             port=5432,
#             user='postgres',
#             password='password',
#             database='products',
#             min_size=6,
#             max_size=6
#         ) as connection_pool:
#             [await query(connection_pool) for _ in range(count)]  # Очень хуёвая строка! await выполняется для каждого запроса поочереди, ненастоящая конкурентность!

#     asyncio.run(run_queries())


async def run_many(pool, queries):
    sends = [query(pool) for _ in range(queries)]
    await asyncio.gather(*sends)


def make_queries(count):
    async def run_queries():
        async with asyncpg.create_pool(
            host='127.0.0.1',
            port=5432,
            user='postgres',
            password='password',
            database='products',
            min_size=6,
            max_size=6
        ) as connection_pool:
            await run_many(connection_pool, count)

    asyncio.run(run_queries())


@util.async_timed()
async def main():
    event_loop = asyncio.get_running_loop()
    process_pool = concfu.ProcessPoolExecutor()
    tasks = [event_loop.run_in_executor(
                process_pool,
                make_queries, 1_000,
            )
            for _ in range(10)
    ]
    await asyncio.gather(*tasks)


if __name__ == '__main__':
    asyncio.run(main())
