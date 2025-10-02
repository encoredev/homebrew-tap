class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.50.2"
    checksums = {
        "darwin_arm64" => "8bb5ea3e92ba16c6f5878eff3ff8cbc13574ddaf1e17b4c4705890c2a2dfdb22",
        "darwin_amd64" => "151c800c46c86ec0b8db58af872ea5835d51c39ca67e0d63c299f2e786ebb604",
        "linux_arm64"  => "e3adb2aacdce29a2dc0a080bf7a4e73252888333da8d7d374751b08fffd2db20",
        "linux_amd64"  => "88e26b2575f81bc43f8ec56306200a8b877651abefcbe40040a59700363bbbc6",
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
