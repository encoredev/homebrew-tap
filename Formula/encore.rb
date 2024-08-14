class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.39.4"
    checksums = {
        "darwin_arm64" => "55d547031f583baefa20f1c4cf0b586cb538e7893b4bb276519f7def51b90475",
        "darwin_amd64" => "d49a32be235c7e96185ffc426018f37a5eb54403c172d089dfaab797ceb9e9ed",
        "linux_arm64"  => "a51c14d7683e8221907b09af6ff23eee3c918dfc281ec4854f38b95a0da3fd3f",
        "linux_amd64"  => "6aff5fdcf5aac5e9f9b3c6cd5d993dc654602df6777f808b7d8925cd6476ed82",
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
