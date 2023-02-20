class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230220"
    checksums = {
        "darwin_arm64" => "4322e937da0f50347fddaa92b5524fd84df47e19da988f9777bfbaacf03cbfaa",
        "darwin_amd64" => "23edccf9f0710c438d89e38dd7cdfa7ffe484f4eec2164cd5ba00cfc996282c7",
        "linux_arm64"  => "7c97e8ee7ca4a0538aaf319c6a112ae0bcde6f0399628f9cd62f76c913d0d2a4",
        "linux_amd64"  => "4fadacb9fb3a75d79d50c615b26561cf7c8e6ef5ec2ef4edb90481d73fd10977",
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
