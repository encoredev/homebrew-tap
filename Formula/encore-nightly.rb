class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230210"
    checksums = {
        "darwin_arm64" => "b11ab0a58220ca8aa36b19b49a7df85c6fb12e2dad9117edac2a3bd3326920de",
        "darwin_amd64" => "0cf8b8f54c063dd23b7b33868cb40f8ffeba44bcffa9ae886c9b9968f08bb0cc",
        "linux_arm64"  => "3f4c37674d74ecf4a88d7ad917051b4e13232af0588626c4ca367e03e8e780a7",
        "linux_amd64"  => "f9343053faf06db003f8659d790744bff6626931110797d8c3105aa6d08ddc9b",
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
