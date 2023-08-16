class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230816"
    checksums = {
        "darwin_arm64" => "e59462118528911c29695c4528cf11fe1b15a9e536ba651ec9d27804dbdf1223",
        "darwin_amd64" => "7df9c8b26685740a88173aa4f82d4d060282351a495f89797f2388b615af81ff",
        "linux_arm64"  => "528a2ceb669078aef71860a1d53360026a50031fbca3cc7f7740cfd9424ccd8e",
        "linux_amd64"  => "2431e30f10a49a06397fb0067c8836c3b6d70be606e7efc090cba8d93bc4894b",
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
