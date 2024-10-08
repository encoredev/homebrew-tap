class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.41.8"
    checksums = {
        "darwin_arm64" => "313e0b70eda1175a963e7d2c0345d628f087ef8eafc7d3ba0b8bb73c9113c386",
        "darwin_amd64" => "8d86ad8e81ac4e4d22165eb191fdd0f21a46eccebbfd91a936d9c17b2df17fe5",
        "linux_arm64"  => "bf1f18b93e0da3646402f79395db015cd026f3b7ab4d643c726f74c9624ff14b",
        "linux_amd64"  => "539c7d2cf6714c401489155b488c16a9d78cbff45bc53be980986dbd702601e8",
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
