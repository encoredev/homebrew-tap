class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231009"
    checksums = {
        "darwin_arm64" => "3e2a09c36e0e11777abcfd778d2694f4dd31e52564243e5dfbee3009b87d3c09",
        "darwin_amd64" => "1ce99f294110fb7125a2ec564116990441f46afc8d629889ceaf2080e2f73a98",
        "linux_arm64"  => "16f9fb5286213c5c6b1b221324fdd0340a5e314cb4264350ac30497b30a4b368",
        "linux_amd64"  => "6137874f378753bff11c7dba0b4625320c9d072aead3a02dd7f40f86a062b986",
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
