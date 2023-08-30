class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.25.2"
    checksums = {
        "darwin_arm64" => "06fd757704e94176fd66597ffa6656d43cefa1dece03db919b0bbc4080e22ff6",
        "darwin_amd64" => "7d2ec63467e699a10a999b4a1440803885faca2acbc4161865e313944d3f6215",
        "linux_arm64"  => "d85164815c60be4a465954726e05cb36826213a6284df5c90cade2b683d5d7cf",
        "linux_amd64"  => "c632572be976410fc0a8bfb11d3af6ca98a50d3de3f08b86984330b82a975198",
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
