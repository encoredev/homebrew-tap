class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230813"
    checksums = {
        "darwin_arm64" => "673d52e48a2accbc50cb2d985167fb3c41dd52d2969fc8493236516f196c6bf0",
        "darwin_amd64" => "4349660a4e60eaa3f57cb9d15b4a0ec72f83d8b934955cd67f7ef5d89dd96be8",
        "linux_arm64"  => "84e7232c5a061429528bd2062e8e8e46eead8441690b61b0c292247c8eeabe34",
        "linux_amd64"  => "5343fa94d735ac97c55fbaa3bfafbfa3fbff7c81c72b7e9e74a38c61704a507d",
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
