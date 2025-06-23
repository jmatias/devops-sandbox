def add(a: int, b: int) -> int:
    """
    Adds two integers and returns the result.

    :param a: First integer
    :param b: Second integer
    :return: Sum of a and b
    """
    return a + b


def subtract(a: int, b: int) -> int:
    """
    Subtracts the second integer from the first and returns the result.

    :param a: First integer
    :param b: Second integer
    :return: Result of a - b
    """
    return a - b

def multiply(a: int, b: int) -> int:
    """
    Multiplies two integers and returns the result.

    :param a: First integer
    :param b: Second integer
    :return: Product of a and b
    """
    return a * b


def divide(a: int, b: int) -> float:
    """
    Divides the first integer by the second and returns the result.

    :param a: First integer
    :param b: Second integer
    :return: Result of a / b
    :raises ValueError: If b is zero
    """
    if b == 0:
        raise ValueError("Cannot divide by zero")
    return a / b
