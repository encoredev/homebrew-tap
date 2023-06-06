class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.20.2"
    checksums = {
        "darwin_arm64" => "f8e6803a9a5b97eee7109d2aec0d7bf5f7ca7ce1cfb876f82dc26ad730b2db94",
        "darwin_amd64" => "d8ceab7f5d56ccca0255927c5ec73575500db35aa9a05f61d3ab2298a222007a",
        "linux_arm64"  => "d8ee01f147573aa88f56782387edc9a51a13066cf4e06fdf3e10616103b4efbb",
        "linux_amd64"  => "436c19880c25c6bd053ac0fec7e3275f6f9ddfa9db00cd8e3081460bd593fdd0",
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
