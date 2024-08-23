import asyncio

async def main():
    await asyncio.sleep(1)
    print("BOOM")

if __name__ == "__main__":
    asyncio.run(main())
    print("hello")