class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231012"
    checksums = {
        "darwin_arm64" => "b25a332c47e75a3ccd13cb6523a164ef8c440bd466828b2d7bdeba0a67ebbeea",
        "darwin_amd64" => "bcbc95458e6c1319b0cf01c3bf84b0751d49a5a197194490a877039a2874a556",
        "linux_arm64"  => "0c2c59832ee6f441a653d275c5c4930ffad3c709a00502d4bc45aeffe74c1e0c",
        "linux_amd64"  => "5802b25e20eb53ab4846d8432032f0f3cf234f21de8888a7f5b26c634ce6531c",
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
