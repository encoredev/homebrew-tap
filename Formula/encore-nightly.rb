class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.30.0-nightly.20231125"
    checksums = {
        "darwin_arm64" => "941cbf7c1c8626887c5e61cb962fef3f606845a57fb815f6f41190e9bf1aef03",
        "darwin_amd64" => "3bc7943b366a575637033658b27a69dccd1aaa1e56e91e5562b28ce3eec09a47",
        "linux_arm64"  => "5667b78b443c78c9194be4c935508682273c4106372a943be98ba355bd457eac",
        "linux_amd64"  => "9183c5ae26b72708cae9090b079d1a744dccb35d61d6cb6531755f3e8c70a4b9",
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

        bin.install_symlink libexec/"bin/encore-nightly"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "bash")
        (bash_completion/"encore-nightly").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "zsh")
        (zsh_completion/"_encore-nightly").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "fish")
        (fish_completion/"encore-nightly.fish").write output
    end

    test do
        system "#{bin}/encore-nightly", "check"
    end
end
