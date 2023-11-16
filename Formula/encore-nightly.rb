class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.25.0-nightly.20231115"
    checksums = {
        "darwin_arm64" => "c117b3d19c8058605815303fd38a8b03321b4e63288c7fab132ad0d87f4261b4",
        "darwin_amd64" => "7b680584bd4c09331f2445a9b92003d447cb2d22db3d6cc7b1ba3319661d3b7a",
        "linux_arm64"  => "b0b41de5e3fa32fe4e9cb1e108fa866ae8cff519156cead14f3b37158f7aabb9",
        "linux_amd64"  => "82a6d75e7f01f618721f474e0f968e289a022645c74f520cbb1f74f866d6562b",
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

        bin.install_symlink libexec/"bin/encore-nightly"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "bash")
        (bash_completion/"encore-nightly").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "zsh")
        (zsh_completion/"_encore-nightly").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "fish")
        (fish_completion/"encore-nightly.fish").write output
    end

    test do
        system "#{bin}/encore-nightly", "check"
    end
end
