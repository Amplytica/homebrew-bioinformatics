require "fileutils"

class Grapple < Formula
  desc "Genome Reference Assembly Pipeline"
  homepage "https://github.com/qsirianni/grapple"
  url "https://github.com/qsirianni/grapple/archive/v0.2.2.tar.gz"
  sha256 "9fa16b50ff1a693f0a55fb52492a63bd3581279c4707aa94a1b57bed9f4a4eb1" 

  # Dependencies
  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "setuptools" => :python

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
    bin.env_script_all_files libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"]
    ln_s "grapple.py", bin/"grapple"
  end

  test do
    # Make sure the script will execute
    system "grapple.py", "-V"
  end
end
