require "fileutils"

class Grapple < Formula
  desc "Genome Reference Assembly Pipeline"
  homepage "https://github.com/qsirianni/grapple"
  url "https://github.com/qsirianni/grapple/archive/v0.2.3.tar.gz"
  sha256 "674dabfab944286aa371aae0c0b6d9bb9014471a56a9ce0640be0673aeaa9728"

  # Dependencies
  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "setuptools" => :python

  depends_on "samtools"
  depends_on "karect"
  depends_on "bowtie2"
  depends_on "bcftools"

  resource "psutil" do
    url "https://pypi.python.org/packages/source/p/psutil/psutil-3.2.2.tar.gz"
    sha256 "f9d848e5bd475ffe7fa3ab1c20d249807e648568af64bb0058412296ec990a0c"
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
