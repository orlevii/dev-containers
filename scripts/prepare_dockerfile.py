from pathlib import Path


def main() -> None:
    dest = Path("Dockerfile")
    python = Path("python.dockerfile").read_text()
    zsh = Path("zsh.dockerfile").read_text()

    final_dockerfile = [zsh, python]
    final_dockerfile_content = "\n".join(final_dockerfile)

    dest.write_text(final_dockerfile_content)


if __name__ == "__main__":
    main()
