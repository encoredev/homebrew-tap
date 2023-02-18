class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230218"
    checksums = {
        "darwin_arm64" => "7733622e4d66669d2f21f219ebccd0b89636c7d3621920128cb4050846458f61",
        "darwin_amd64" => "249c96663e28a92c74d78f017c480ae054119dd6b083fa23c9044ab5a15e1f3e",
        "linux_arm64"  => "13538b9d3f834ae1ec32dea7d874c0eac0e82da8ffc2efb28513546d63d55694",
        "linux_amd64"  => "d2d6bed9412840aa7cbb164676be2e14dc0f033bb7b6007b222e5c2e694d36bf",
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
