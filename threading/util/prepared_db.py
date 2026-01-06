import asyncpg


async def get_db_connection():
    return await asyncpg.connect(
        host='127.0.0.1',
        port=5432,
        user='postgres',
        database='products',
        password='password',
    )
