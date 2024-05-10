class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.37.1"
    checksums = {
        "darwin_arm64" => "9d32ad9f46af9f7d04be607ad80a85541118cb35051ac5cd747e259b2d76efcd",
        "darwin_amd64" => "e07e38e470e3741988f836cd2fde21fef5b53acc8bd05fc19a0a7e65de6c42cd",
        "linux_arm64"  => "58e9efda41f72cd3b50520bf2085870926f3d13e6dfae3b960791a58dfaeb75c",
        "linux_amd64"  => "6693ff5b8831fa874e40942854eadfb65fb0f894cf2f6202705822aee4bbdd06",
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
