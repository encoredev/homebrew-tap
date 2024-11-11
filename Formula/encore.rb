class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.43.9"
    checksums = {
        "darwin_arm64" => "fa39cb99a97366a636bc5f01ed658dcafaedef35b91457a7df22f7bf805038e8",
        "darwin_amd64" => "e68fca5ed5aba7753753a5e05a2e2975fdc654d38aa9202e61e87050d1527363",
        "linux_arm64"  => "4dc6ff4e4751e3105194d99581f6b525bca20d9607766679576e6ac796c0a833",
        "linux_amd64"  => "763232b334e0a7fbaa3998c02ce358be0a267a8a29f0362bdf44f6efece84a4c",
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
