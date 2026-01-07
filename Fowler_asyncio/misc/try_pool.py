import asyncio
import asyncpg


PRODUCT_QUERY = """
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
i = 1


async def query_product(pool: asyncpg.Pool):
    async with pool.acquire() as connection:
        res = await connection.execute(PRODUCT_QUERY)
        global i
        print(f'done {i}!')
        i += 1
        return res


async def main():
    async with asyncpg.create_pool(
        min_size=6,
        max_size=6,

        host='127.0.0.1',
        port=5432,
        user='postgres',
        database='products',
        password='password',
    ) as pool:
        await asyncio.gather(
            *[query_product(pool) for _ in range(10_000)]
        )


asyncio.run(main())
