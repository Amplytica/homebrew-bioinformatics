class Ipa < Formula
  desc "Iontorrent Pipeline Assembler"
  homepage "https://github.com/qsirianni/ipa"
  url "https://github.com/qsirianni/ipa/archive/v0.1.0.tar.gz"
  sha256 "1f092308c2d561a0e68de8bf4963ae523e3a64c5daa040ea082b7f0e485ecce7"

  depends_on "samtools"
  depends_on "karect"
  depends_on "bowtie2"
  depends_on "bcftools"
  depends_on "psutils" => :python

  def install
    # Move the IPA script to the bin
    bin.install "ipa.py"
  end

  test do
    # Run the test cases in the included test script
    system "tests.py"
  end
end
