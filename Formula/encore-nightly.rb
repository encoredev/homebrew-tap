class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221105"
    checksums = {
        "darwin_arm64" => "c7c5f6a7503cb56f1724c6352302a335657e590b1caccfecadf7e9811302485f",
        "darwin_amd64" => "a1403db1505795c5f943e214c230023cbb3532cb9ba22a50ccc2716bb0e2ce02",
        "linux_arm64"  => "39a90a9ae31b7049f4eb532633eab5fcdbf85e2d71ecdfb8e82b2c743f1ceeac",
        "linux_amd64"  => "106b7b5d7d8022790481a1b1ee8a4808dad180ccc08a6d2ac371f28ab06f6d99",
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
