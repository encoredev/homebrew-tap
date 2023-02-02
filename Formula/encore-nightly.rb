class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230202"
    checksums = {
        "darwin_arm64" => "9fdca6e0462baf93c94ba4b0ce02c30359eb47fe454d4e1425f8b1fb8b3fd420",
        "darwin_amd64" => "d1b7cba53de50e35dcd7bc2de13398cb3e12c79620c1404e1e3bf4bc8e352fc5",
        "linux_arm64"  => "ff1243982ac1aa920e280870ad0044162669cd8a18ff81a3dddb1f301209333d",
        "linux_amd64"  => "78c91a86d8f9910dd0f5925929d739264f8e38396796e4c79fe3ca28d71776b6",
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
