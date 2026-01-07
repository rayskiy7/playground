import asyncio
import asyncpg
import random
import util


def get_random_names():
    with open("chapter_05/common_words.txt") as file:
        lines = list(map(lambda x: (x.strip(), ), file.readlines()))
        return random.sample(lines, 100)


async def main():
    con: asyncpg.connection.Connection = await util.get_db_connection()

    await con.executemany(
        "INSERT INTO brand VALUES(DEFAULT, $1)",
        get_random_names(),
    )


asyncio.run(main())
