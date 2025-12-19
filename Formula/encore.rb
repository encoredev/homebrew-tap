class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.53.2"
    checksums = {
        "darwin_arm64" => "a77e0acad6d175fb9a2aa331e743b1fcb678866ea5641624b61810a04df9f206",
        "darwin_amd64" => "6ccc4e24da7eea3b5eaafbc29120d0a1cfe276cae15c0325a5cc6e96f09f4d9a",
        "linux_arm64"  => "004e35f3eaa679b37b9c159d59e60caaacfe65b2e8630738f5aa47b48951adbe",
        "linux_amd64"  => "10db0081890a8aea857d835c64863f108018b1a6dac275f9cf895384b74f1f27",
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
