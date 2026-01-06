import asyncio
import util


QUERY = "SELECT product_id FROM product"


async def take(cursor, records_count):
    agen = aiter(cursor)
    while records_count:
        try:
            yield await anext(agen)
        except StopAsyncIteration:
            return
        records_count -= 1


async def main():
    connection = await util.get_db_connection()
    async with connection.transaction():
        cursor = connection.cursor(QUERY)
        async for el in take(cursor, 17):
            print(el)

    await connection.close()


asyncio.run(main())
