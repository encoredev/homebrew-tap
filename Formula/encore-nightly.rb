class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230510"
    checksums = {
        "darwin_arm64" => "c1fdcd01039e7b474fefcb2c0a20529a861104ce27e649de67a289e134fc42c3",
        "darwin_amd64" => "0c96878f8af503645d9c80bbadf6d2dac417327f8532472945b7855bc6e61de2",
        "linux_arm64"  => "0959aaf72ea94a05e5364fa09344e0da805fe23faabd64b3f59629a582e98646",
        "linux_amd64"  => "1fe416315a0ebe5e66991d078f2b3f67271ffdc21712f347afe4f426d2d4198d",
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
