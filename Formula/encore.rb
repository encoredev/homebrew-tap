class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.17.0"
    checksums = {
        "darwin_arm64" => "8fc80d4024d2974e56f8d9651ff1ac7c96ea3165b0780b365d08cb11297daecc",
        "darwin_amd64" => "421263387d937b20ed4763ebbb640ab7504129510db7782c6ae5d22f295350c6",
        "linux_arm64"  => "03c6fac2970e5d135f8c7ef587b5def0f4d230728dad5d77b2b07f362dc28c0f",
        "linux_amd64"  => "3c94b1a872d3ee1ad8c557d66078b66f1941bf0be13b9daa382da8deacaad5b7",
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
