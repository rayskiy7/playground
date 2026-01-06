import asyncio
import util


QUERY = """
    SELECT
        product_id, product_name, brand_id
    FROM
        product
"""


async def main():
    db = await util.get_db_connection()
    async with db.transaction():
        async for el in db.cursor(QUERY):
            print(el)

    await db.close()


asyncio.run(main())
