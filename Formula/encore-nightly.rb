class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230802"
    checksums = {
        "darwin_arm64" => "5ebf21455590a699995f7c0122b1c892def32decc95174907295e2fa27867169",
        "darwin_amd64" => "cc7305b9681e7e42880c77d50abadc4e5e2ccd38d6db6a66634ec04a9d3d496c",
        "linux_arm64"  => "a0cb819277833e021be215b42fd68c4f595ac337eb6fe93aacdfb0fc4d6663b5",
        "linux_amd64"  => "ead03cc67ce5a6f11d7753f9d256703789bff7d13d65f1c799d01977aebb0670",
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
