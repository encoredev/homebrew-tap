class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231102"
    checksums = {
        "darwin_arm64" => "398f350e87e352a76beeec33489bb4d561f70eef529852127d950b715103e264",
        "darwin_amd64" => "44b9f6ed93f272b367c6e0b60507384ede58720e9ea7b54a0bf6a3351483437d",
        "linux_arm64"  => "c3412ea2408c2beb68f87a56a18a8178240b14516773902fe06ec3f2f663bea2",
        "linux_amd64"  => "c2a7fd2f7332c074f72d3c88bd282f211e12c823ecaa30dc85971e41a5f58830",
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
