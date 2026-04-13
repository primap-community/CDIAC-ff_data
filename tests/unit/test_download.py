from cdiac_ff_data import download_version


def test_download(capfd):
    version = "1.2.3"
    expected = version
    result = download_version(version)
    assert result == expected

    out, _err = capfd.readouterr()
    assert f"test {version}" in out
