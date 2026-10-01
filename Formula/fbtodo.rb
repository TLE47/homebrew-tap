# fbtodo — installed from the PyPI source distribution.
#
# This formula lives in the tap `TLE47/homebrew-tap`, at `Formula/fbtodo.rb`,
# which is what makes `brew install TLE47/tap/fbtodo` work (and, once tapped,
# `brew install fbtodo`). `packaging/homebrew/update-formula.py` writes the
# `url`/`sha256` below from the release that is actually on PyPI — see the
# tap's README for the two ways to fill them in.
#
# fbtodo has no Python dependencies, so there are no `resource` blocks: a venv
# is created and this source is pip-installed into it, which generates the
# `fbtodo` console script that the formula links onto the PATH.
class Fbtodo < Formula
  include Language::Python::Virtualenv

  desc "Live todo pane beside your coding agent"
  homepage "https://github.com/TLE47/fbtodo"
  url "https://files.pythonhosted.org/packages/a0/fe/d33a71fbad97890382ee239e0bb59d9da8d38bf778fb0d65216a824f9e95/fbtodo-4.30.2.tar.gz"
  sha256 "ed4b226db05786285e4741b7b3744d3476c08073695255a80f24e2d3e646c7ce"
  license "MIT"
  head "https://github.com/TLE47/fbtodo.git", branch: "main"

  depends_on "python@3.13"

  livecheck do
    url "https://pypi.org/pypi/fbtodo/json"
    strategy :pypi
  end

  def install
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install_and_link buildpath
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fbtodo --version")
  end
end
