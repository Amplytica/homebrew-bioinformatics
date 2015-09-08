class Karect < Formula
  desc "KAUST Assembly Read Error Correction Tool"
  homepage "https://aminallam.github.io/karect/"
  url "https://github.com/aminallam/karect/archive/v1.0.tar.gz"
  sha256 "47d90bf2e6d4dd26a48bcf9c8041cbe95af0bec48d2488422485378fd8c35681"

  def install
    system "make"
    bin.install "karect"
  end

  test do
    # Attempt to run the karect binary
    system "karect"
  end
end
