class Ipa < Formula
  desc "Iontorrent Pipeline Assembler"
  homepage "https://github.com/qsirianni/ipa"
  url "https://github.com/qsirianni/ipa/archive/v0.1.0.tar.gz"
  sha256 "8e0f20a9b0594bd2cf16aa48f8b40d4f10a3434097ab2b3d7870b92b43f950a6"

  # Dependencies
  depends_on :python if MacOS.version <= :snow_leopard

  depends_on "samtools"
  depends_on "karect"
  depends_on "bowtie2"
  depends_on "bcftools"

  resource "psutil" do
    url "https://pypi.python.org/packages/source/p/psutil/psutil-3.2.1.tar.gz"
    sha256 "7f6bea8bfe2e5cfffd0f411aa316e837daadced1893b44254bb9a38a654340f7"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    resource("psutil").stage do
      system "python", *Language::Python.setup_install_args(libexec/"vendor")
    end

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(libexec)

    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    # Make sure IPA runs in the current environment
    system "ipa.py", "-e"
  end
end
