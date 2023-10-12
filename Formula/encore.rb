class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"

    release_version = "1.27.5"
    checksums = {
        "darwin_arm64" => "0b130d6279ce87677a0414cf6710184e7b228cac7fa4ae1dd694b78c2e1e894d",
        "darwin_amd64" => "77cce48c5d1fe2f0c6e232c3a754fd261b4e3369a9ae827906b3b164b648d46b",
        "linux_arm64"  => "15d0b90c6114c8a0f3d531da4660d4a798ea746375788c951b28802e1a764e9c",
        "linux_amd64"  => "1f091569a14ecfd542c17abf850c213aaf598b7c19ead4f265986a0b5a731518",
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
