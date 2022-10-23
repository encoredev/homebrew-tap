class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221023"
    checksums = {
        "darwin_arm64" => "810f2a53cacfddc6f3842733487776ac798d1c415da0cb907b31db6648270577",
        "darwin_amd64" => "dddae5558249699ad819320c5f2a1b72b75918c0a8187bcb0bd86714c594b9de",
        "linux_arm64"  => "999b6414583b28d968d1e0db1c61266673c56e6378c46c3584b7cc3e8902cd37",
        "linux_amd64"  => "603989899f2ab4763ee10f01110f830578dc3d6dcd4b7fd2e09413e2761c63c9",
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
