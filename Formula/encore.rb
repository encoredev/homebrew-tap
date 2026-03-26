class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.56.2"
    checksums = {
        "darwin_arm64" => "9e3b836a9cae17223f0ed2970d4a6d907e2d5c214d0cc923a10adf1fa53654df",
        "darwin_amd64" => "aa39b27b92f8ba571c63d76c0f0baf30ea7c62cb32eb8020aa0e41e0dcdb82c6",
        "linux_arm64"  => "746a1fd36f027d7698df15076a2b5ed0684bd7cbd1eadc31a6260aea953ac7bc",
        "linux_amd64"  => "0f42b4b86e3d734b24df3f4d28bc04341e9c1162db7425c2b4e6446efcd0f9ca",
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
