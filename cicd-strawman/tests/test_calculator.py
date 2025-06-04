from cicd.strawman.calculator import add, subtract, divide


def test_add():
    # ARRANGE

    a = 5
    b = 3

    # ACT
    result = add(a, b)

    # ASSERT
    assert result == 8, f"Expected 8, but got {result}"


def test_subtract():
    # ARRANGE

    a = 5
    b = 3

    # ACT
    result = subtract(a, b)

    # ASSERT
    assert result == 2, f"Expected 2, but got {result}"


def test_multiply():
    # ARRANGE
    a = 5
    b = 3

    # ACT
    result = a * b

    # ASSERT
    assert result == 15, f"Expected 15, but got {result}"

def test_divide():
    # ARRANGE
    a = 6
    b = 3

    # ACT
    result = divide(a, b)

    # ASSERT
    assert result == 2, f"Expected 2, but got {result}"
