class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.41.3"
    checksums = {
        "darwin_arm64" => "be4beef09707fceb1d505d30569f62a4ef539fac23149053d18188b248be7ca7",
        "darwin_amd64" => "f2bcc4b450529350657bd769562c5e057034baa3170a7ab8b6d7ec68201fc7d3",
        "linux_arm64"  => "c11c80d1ff8c43eee1a0b27f987e826fbfc0aed8aa204d1ba712fcebbb99717c",
        "linux_amd64"  => "09b2ca93274234a0b96a8aa55e6be9a60eb1c9fa4fb9fcba5dd082f8b071d18e",
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
