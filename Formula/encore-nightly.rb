class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230414"
    checksums = {
        "darwin_arm64" => "d303530f91907ffff0db6216ac0303cc4e212b0be4dadae0f7cc84b48fbd6fda",
        "darwin_amd64" => "4acac5d8659e56d5733f4637c76969e2d6d53fe6292a950affe9359cdaf26ccc",
        "linux_arm64"  => "f3e4f9226a14fe6c4af5adfed94a214e341f95d95c79301364a6e58774188143",
        "linux_amd64"  => "f3759c012198022152f7fbaffb20efb53afa4b8b3d73210ec45a80e3fe205a38",
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
