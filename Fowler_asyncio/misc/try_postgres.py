import asyncio
import asyncpg


async def main():
    connection = await asyncpg.connect(
        host='127.0.0.1',
        port=5432,
        user='postgres',
        password='password',
        database='postgres',
    )

    print(connection.get_server_version())
    await connection.close()


asyncio.run(main())
