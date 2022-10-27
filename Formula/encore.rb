class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.9.3"
    checksums = {
        "darwin_arm64" => "0deb039fbb5509878430a0d11daa3a010282355309905448410c0105d771d0ef",
        "darwin_amd64" => "669ba8520877525826983ab5108fec59cf0f292ffb10b7872b6b95ead6391b43",
        "linux_arm64"  => "9a76e16ac3d5f455dd3c3683f3c54b4f40143e4f8993ca48b585118d989a8bbb",
        "linux_amd64"  => "41b0d7088dba53b2e639a5ab8c1e76f70bfa0c220443a7fff4da1c0d4f08ee5b",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]
        bin.install_symlink Dir[libexec/"bin/*"]

        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
