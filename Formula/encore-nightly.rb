class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221207"
    checksums = {
        "darwin_arm64" => "f4df3c3c31c607de4700a0b5f493c3a33372d1089442aa21ef0869e91998ac71",
        "darwin_amd64" => "b6c700f860d6cc315d9b743f0f67755de7d2d62ae3d1e8885b2bc7887c98b77c",
        "linux_arm64"  => "6d4d4310ae48c3d1e3fafabcf40ff78295d903761bb1d46b27aaf761f84a7740",
        "linux_amd64"  => "38dec3887bbf6efb1972428943ff44f165148bd804b800fee0d4b35bd8a71606",
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
