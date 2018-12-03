class Clisso < Formula
  desc "Get temporary credentials for cloud providers from the command-line"
  homepage "https://github.com/allcloud-io/clisso"
  url "https://github.com/allcloud-io/clisso/archive/0.6.0.tar.gz"
  sha256 "438ebf6c75ebe46333c20b6b0aa46baa86a351f9a52999b689eed36dbc368fc3"

  bottle do
    root_url "https://github.com/allcloud-io/clisso/releases/download/0.6.0"
    cellar :any_skip_relocation
    sha256 "132cfbc15a8f98c6ccf24f8f2e20edd0006045f9eff3bee57c25343aa1da5e1b" => :mojave
  end

  depends_on "dep" => :build
  depends_on "go" => :build
  depends_on "make" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV.prepend_create_path "PATH", buildpath/"bin"
    dir = buildpath/"src/github.com/allcloud-io/clisso"
    dir.install buildpath.children - [buildpath/".brew_home"]
    cd dir do
      system "dep", "ensure", "-vendor-only"
      ENV["VERSION"] = version
      system "make", "-e"
      bin.install "clisso" => "clisso"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test clisso`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/clisso", "version"
  end
end
