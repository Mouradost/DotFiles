import sqlparse
import sys


def main():
    content = sys.stdin.read()

    results = sqlparse.format(
        content,
        keyword_case="upper",
        identifier_case="lower",
        output_format="sql",
        strip_comments=True,
        use_space_around_operators=True,
        strip_whitespace=True,
        indent_columns=True,
        reindent=True,
        indent_after_first=False,
        wrap_after=80,
        comma_first=True,
    )

    print(results.strip())


if __name__ == "__main__":
    main()
