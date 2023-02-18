class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230218"
    checksums = {
        "darwin_arm64" => "2a1dabac64ba9ba271307133216c3df8736db07969ae3672d7a36ba5e3061b02",
        "darwin_amd64" => "cd7a21a9ff97c6dcfc41dda187512d859c091376622bcd9c3872e8506c7b752a",
        "linux_arm64"  => "feae434347feafed5edb3b6430f379d9ae1aab866d58e87cc45bc97ea7c6151a",
        "linux_amd64"  => "619184af4ce30951fb57315fb3ef82378709e99c6085de7aa81f5d892a34b4b3",
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
