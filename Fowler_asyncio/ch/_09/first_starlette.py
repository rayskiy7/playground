import asyncpg
from starlette.applications import Starlette
from starlette.requests import Request
from starlette.responses import JSONResponse, Response
from starlette.routing import Route


async def create_db_pool():
    app.state.DB = await asyncpg.create_pool(
        host='127.0.0.1',
        port=5432,
        user='postgres',
        database='products',
        password='password',
        min_size=6,
        max_size=10,
    )


async def destroy_db_pool():
    await app.state.DB.close()


async def brands(request: Request) -> Response:
    connection = request.app.state.DB
    results = await connection.fetch(
        'SELECT brand_id, brand_name FROM brand'
    )

    return JSONResponse(
        dict(results)
    )


app = Starlette(
    routes=[
        Route('/brands', brands),
    ],
    on_startup=[create_db_pool],
    on_shutdown=[destroy_db_pool],
)
