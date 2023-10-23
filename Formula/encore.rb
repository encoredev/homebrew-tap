class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.27.7"
    checksums = {
        "darwin_arm64" => "a11dba5adc248acea6b4817ce7309a5cdb1e49911f88f7f41cde0fa73e85e5ef",
        "darwin_amd64" => "64df01da415d49acd612e6a44a664bca342f0adc4f0a4d171718c9dd0512be5a",
        "linux_arm64"  => "ae3ee2d3c72ef24ad22bb1cdc1b3820c959c4a305ef22675240f820a3e14de47",
        "linux_amd64"  => "5bb7ae093b808fcbd91c9dea20a0f517d94a55a7ddee8a63d6d728fc58c58af8",
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
