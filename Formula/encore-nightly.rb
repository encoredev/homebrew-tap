class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230403"
    checksums = {
        "darwin_arm64" => "68d7d8c3e8bb92a2deee7b38dde49ce77dfe25e9681949c1d1b6b3696fd87466",
        "darwin_amd64" => "662f3f073a28d6e3010f8fb5ba94c8226d0b782d21d911d00d5de9c6c437acce",
        "linux_arm64"  => "686a96190fe9187828b8810a0a837e5de3b20c2d1b866d28ba16bb48c04f624e",
        "linux_amd64"  => "8adbc621111a59e436decb08103f2268c117e319eb6d06ed219ec44f9c7c9e70",
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
