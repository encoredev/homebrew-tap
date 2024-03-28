class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.6"
    checksums = {
        "darwin_arm64" => "07ced835f436005fd788e7b70227bdacec403bab3d17774d25f7e76073a806ed",
        "darwin_amd64" => "90b16a6379046d027caaf0d1aa00374f21007175c4d142df2f3a8027c521056d",
        "linux_arm64"  => "3241a9d9d0411c018378e3908d768a6d1b0c8f05cbd7f8121680fad12dbdbe6d",
        "linux_amd64"  => "77a96e4792aa0e348721bbbccc8eb459595902b7ec94aaad6f6a2a2c9680bdcb",
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
