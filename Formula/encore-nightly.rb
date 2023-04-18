class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230418"
    checksums = {
        "darwin_arm64" => "d5b62ff6d08d74ba15845c4adf4d8cca224c4255784e6f67d58d74dba97047b2",
        "darwin_amd64" => "8aeea1c0d5a98e68f0b39e7c6c27b4f20990c779c5c50857df089ecc1f2dd440",
        "linux_arm64"  => "9513e543faeb8acbd6d11212837eb7594f5b4583ab517dfea753e47e6930c895",
        "linux_amd64"  => "1c655ff13a244808ff0cbd5ab2e10322505cb5f3cdc0a73ddff95d4908238087",
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
