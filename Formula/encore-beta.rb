class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.32.2-beta.9"
    checksums = {
        "darwin_arm64" => "e30cf94a7ebb40bbf11882925cd767e67b7868f61dcf1a9a74146edca0c10d28",
        "darwin_amd64" => "7e9f77327ab93d271226dbe9ef6642012c282204325d4740a01197451ce118a8",
        "linux_arm64"  => "2540d44a5355bbbd9340f3e88ec800a5c89a240750711bcef4d3c817dcdf3693",
        "linux_amd64"  => "4e6cef7e8238a1affcc25183308278d5c708663ef7fcce62330335a654446996",
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

        bin.install_symlink libexec/"bin/encore-beta"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "bash")
        (bash_completion/"encore-beta").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "zsh")
        (zsh_completion/"_encore-beta").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "fish")
        (fish_completion/"encore-beta.fish").write output
    end

    test do
        system "#{bin}/encore-beta", "check"
    end
end
